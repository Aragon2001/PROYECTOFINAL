<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>
<html lang="es">
<head runat="server">
  <meta charset="utf-8" />

  <title>Login - El Zapatero</title>

  <!-- Bootstrap & Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />

  <style>
    body {
      background-image: linear-gradient(to bottom, rgba(13,110,253,0.3), rgba(0,0,0,0.5)),
        url('https://images.unsplash.com/photo-1607703701575-df8d2eecc7de?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80');
      background-size: cover;
      background-position: center;
      font-family: 'Segoe UI', sans-serif;
      color: #333;
    }
    .login-container {
      backdrop-filter: blur(8px);
      background-color: rgba(255, 255, 255, 0.9);
      padding: 2rem 2rem 2.5rem;
      border-radius: 1rem;
      box-shadow: 0 0 25px rgba(0, 0, 0, 0.1);
      animation: fadeIn 0.8s ease;
    }
    @keyframes fadeIn {
      from { opacity: 0; transform: scale(0.95); }
      to { opacity: 1; transform: scale(1); }
    }
    .form-label {
      font-weight: 500;
    }
    .btn-custom {
      border-radius: 2rem;
    }
    .text-muted small {
      font-size: 0.8rem;
    }
  </style>
</head>
<body class="d-flex justify-content-center align-items-center vh-100">
  <form id="form1" runat="server">
    <div class="login-container" style="max-width: 420px; width: 100%;">
      <h3 class="text-center text-primary mb-3"><i class="bi bi-person-circle"></i> El Zapatero</h3>
      <p class="text-center mb-4 text-muted">Accede a tu cuenta para continuar</p>

      <div class="mb-3">
        <label for="txtUsuario" class="form-label">Usuario</label>
        <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control" placeholder="Nombre de usuario" />
        <asp:RequiredFieldValidator ID="rfvUsuario" runat="server"
          ControlToValidate="txtUsuario" CssClass="text-danger"
          ErrorMessage="Ingrese su usuario" Display="Dynamic" />
      </div>

      <div class="mb-3">
        <label for="txtClave" class="form-label">Contraseña</label>
        <asp:TextBox ID="txtClave" runat="server" CssClass="form-control" TextMode="Password" placeholder="********" />
        <asp:RequiredFieldValidator ID="rfvClave" runat="server"
          ControlToValidate="txtClave" CssClass="text-danger"
          ErrorMessage="Ingrese su contraseña" Display="Dynamic" />
      </div>

      <asp:Button ID="btnLogin" runat="server" Text="Ingresar"
        CssClass="btn btn-primary w-100 btn-custom"
        OnClick="btnLogin_Click" />

      <div class="text-center mt-3">
        <small class="text-muted">¿Olvidaste tu contraseña? Contacta al administrador.</small>
      </div>
    </div>
  </form>
</body>
</html>
