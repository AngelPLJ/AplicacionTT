// lib\features\tutor\presentacion\estados\autenticacion.dart

sealed class AuthState {
  const AuthState();
}
class AuthInitial extends AuthState { const AuthInitial(); }
class AuthLoading extends AuthState { const AuthLoading(); }
class AuthAuthenticated extends AuthState { const AuthAuthenticated(); }
class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}
