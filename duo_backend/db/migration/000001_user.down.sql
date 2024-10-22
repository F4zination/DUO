DROP TABLE IF EXISTS user_login;
DROP TABLE IF EXISTS duouser;

DROP TYPE IF EXISTS USERSTATUS;

REVOKE duo_user_role FROM duo_user;
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM duo_user_role;
REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public FROM duo_user_role;
REVOKE ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public FROM duo_user_role;
REVOKE ALL PRIVILEGES ON SCHEMA public FROM duo_user_role;

DROP ROLE IF EXISTS duo_user_role;
