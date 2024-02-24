package db

import (
	"context"
	"database/sql"
	"log"
)

type Store interface {
	Querier
	ExecTx(context.Context, func(*Queries) error) error
}

type SQLStore struct {
	*Queries
	db *sql.DB
}

func NewStore(db *sql.DB) Store {
	return &SQLStore{
		db:      db,
		Queries: New(db),
	}
}

func (store *SQLStore) ExecTx(ctx context.Context, fn func(*Queries) error) error {
	tx, err := store.db.BeginTx(ctx, nil)
	if err != nil {
		log.Fatalf("Error creating transaction: %s", err)
		return err
	}
	defer tx.Rollback()

	qtx := New(tx)
	err = fn(qtx)
	if err != nil {

		if rollbackErr := tx.Rollback(); rollbackErr != nil {
			return rollbackErr
		}
		return err
	}
	return tx.Commit()
}
