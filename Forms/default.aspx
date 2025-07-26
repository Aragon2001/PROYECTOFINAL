<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <title>El Zapatero - Inicio</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background: linear-gradient(to right, #e9efff, #fdfdfd);
            font-family: 'Segoe UI', sans-serif;
            color: #333;
        }

        .container {
            max-width: 1000px;
            margin: 4rem auto;
            background: #fff;
            padding: 3rem;
            border-radius: 20px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.1);
        }

        h1 {
            font-size: 2.8rem;
            color: #0d47a1;
            margin-bottom: 1rem;
        }

        .info p {
            font-size: 1.2rem;
            margin: 0.5rem 0;
        }

        .video-box iframe {
            border-style: none;
            border-color: inherit;
            border-width: medium;
            width: 100%;
            height: 578px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        .btn {
            display: inline-block;
            padding: 0.75rem 2rem;
            font-size: 1.1rem;
            color: #fff;
            background: #007bff;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            text-decoration: none;
            transition: background 0.3s ease;
            margin-top: 2rem;
        }

        .btn:hover {
            background: #0056b3;
        }

        .footer {
            text-align: center;
            font-size: 0.9rem;
            color: #777;
            margin-top: 3rem;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
           

            <div class="info">
                <h1>Bienvenido a El Zapatero</h1>
                <p><strong>Versión:</strong> 1.0</p>
                <p><strong>Empresa:</strong> El Zapatero</p>
                <p><strong>Desarrolladores:</strong> Jostin Aragón Barboza</p>
<div class="video-box">
    <iframe width="560" height="315"
        src="https://www.youtube.com/embed/c9k6sm-5-X8?autoplay=1&mute=1&loop=1&playlist=c9k6sm-5-X8&controls=1"
        title="YouTube video player" frameborder="0"
        allow="autoplay; encrypted-media"
        allowfullscreen="false"
        referrerpolicy="strict-origin-when-cross-origin">
    </iframe>
</div>

                <asp:Button ID="btnEntrar" runat="server" CssClass="btn" Text="Entrar al sistema" OnClick="btnEntrar_Click" />
            </div>

            <div class="footer">
                &copy; 2025 El Zapatero. Todos los derechos reservados.
            </div>
        </div>
    </form>
</body>
</html>
