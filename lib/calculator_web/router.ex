defmodule CalculatorWeb.Router do
  use CalculatorWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug(CalculatorWeb.AuthPipeline)
  end

  scope "/api", CalculatorWeb do
    pipe_through :api

    scope "/v1" do
      scope "/users" do
        resources("/", UserController, only: [:show, :create])
      end

      scope "/sessions" do
        resources("/", SessionController, only: [:create])
      end

      scope "/records" do
        resources("/", RecordController, only: [:create, :delete, :index, :update])
      end

      scope "/operations" do
        resources("/", OperationController, only: [:index])
      end
    end
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:calculator, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: CalculatorWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
