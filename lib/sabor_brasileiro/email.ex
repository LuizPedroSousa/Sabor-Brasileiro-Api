defmodule SaborBrasileiro.Email do
  import Bamboo.Email
  use Bamboo.Phoenix, view: SaborBrasileiroWeb.EmailView
  alias SaborBrasileiro.{User, TemporaryUserPin}

  def send_auth_pin(
        %User{email: email, name: name},
        %TemporaryUserPin{pin: pin, expires_in: expires_in},
        conn
      ) do
    ip =
      :inet.ntoa(conn.remote_ip)
      |> to_string()

    assigns = [
      name: name,
      pin: pin,
      location: "São paulo, Sp",
      expires_in:
        Timex.from_unix(expires_in)
        |> Timex.to_datetime("America/Sao_Paulo")
        |> Timex.format!("{WDfull} ás {h24}:{m}:{s} de {YYYY}"),
      remote_ip: ip,
      browser: Browser.full_browser_name(conn),
      platform: Browser.full_platform_name(conn)
    ]

    new_email(
      to: email,
      from: "support@saborbrasileiro.com",
      subject: "Seu código de verificação de login da loja #{pin}"
    )
    |> render("auth_pin.html", assigns)
    |> SaborBrasileiro.Mailer.deliver_now!()

    :ok
  end
end