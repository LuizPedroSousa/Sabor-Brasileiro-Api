defmodule SaborBrasileiro.Email do
  import Bamboo.Email
  use Bamboo.Phoenix, view: SaborBrasileiroWeb.EmailView
  alias SaborBrasileiro.{User, UserOTP}

  alias SaborBrasileiro.Users.Auth.ValidateCredentials.OTPResponse

  def send_auth_pin(
        %User{email: email, name: name},
        %UserOTP{otp_code: otp_code, expires_in: expires_in},
        conn
      ) do
    ip =
      :inet.ntoa(conn.remote_ip)
      |> to_string()

    assigns = [
      name: name,
      pin: otp_code,
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
      subject: "Seu código de verificação de login da loja #{otp_code}"
    )
    |> render("auth_pin.html", assigns)
    |> SaborBrasileiro.Mailer.deliver_now!()

    :ok
  end
end
