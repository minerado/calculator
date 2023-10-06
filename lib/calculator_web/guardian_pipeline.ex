defmodule CalculatorWeb.AuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :calculator,
    error_handler: CalculatorWeb.GuardianErrorHandler,
    module: Calculator.Guardian

  plug(Guardian.Plug.VerifySession, claims: %{"typ" => "access"})
  plug(Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"})

  plug(Guardian.Plug.LoadResource, allow_blank: true)
end
