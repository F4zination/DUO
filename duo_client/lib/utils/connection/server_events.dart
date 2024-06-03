import 'package:duo_client/pb/friend.pb.dart';
import 'package:duo_client/pb/game.pb.dart';
import 'package:duo_client/pb/lobby.pb.dart';
import 'package:duo_client/pb/notification.pb.dart' as notification;

sealed class ServerEvent {
  const ServerEvent();
}

class LobbyStatusEvent extends ServerEvent {
  final LobbyStatus status;

  LobbyStatusEvent(this.status);
}

class LobbyStatusDoneEvent extends ServerEvent {
  LobbyStatusDoneEvent();
}

class GameStateEvent extends ServerEvent {
  final GameState state;

  GameStateEvent(this.state);
}

class GameStateDoneEvent extends ServerEvent {
  GameStateDoneEvent();
}

class StackStateEvent extends ServerEvent {
  final StackState state;

  StackStateEvent(this.state);
}

class StackStateInitEvent extends ServerEvent {
  StackStateInitEvent();
}

class StackStateDoneEvent extends ServerEvent {
  StackStateDoneEvent();
}

class PlayerStateEvent extends ServerEvent {
  final PlayerState state;

  PlayerStateEvent(this.state);
}

class PlayerStateDoneEvent extends ServerEvent {
  PlayerStateDoneEvent();
}

class NotificationEvent extends ServerEvent {
  final notification.Notification newNotification;

  NotificationEvent(this.newNotification);
}

class NotificationDoneEvent extends ServerEvent {
  NotificationDoneEvent();
}

class UserStatusAckEvent extends ServerEvent {
  UserStatusAckEvent();
}

class UserStatusInitEvent extends ServerEvent {
  UserStatusInitEvent();
}

class UserStatusDoneEvent extends ServerEvent {
  UserStatusDoneEvent();
}

class GetFriendsEvent extends ServerEvent {
  final List<Friend> friends;

  GetFriendsEvent(this.friends);
}

class RegisterUserEvent extends ServerEvent {
  final String uuid;
  final String username;
  final String accessToken;
  final String privatePEMKey;

  RegisterUserEvent({
    required this.uuid,
    required this.username,
    required this.accessToken,
    required this.privatePEMKey,
  });
}

class LoginUserEvent extends ServerEvent {
  final String token;
  final DateTime expirationDate;

  LoginUserEvent({
    required this.token,
    required this.expirationDate,
  });
}
