defmodule RumblWeb do
  def controller do
    quote do
      use Phoenix.Controller, namespace: RumblWeb

      alias Rumbl.Repo
      import Ecto
      import Ecto.Query, only: [from: 1, from: 2]

      import Plug.Conn
      import RumblWeb.Gettext
      alias RumblWeb.Router.Helpers, as: Routes

      import Rumbl.Auth, only: [authenticate_user: 2]
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/rumbl_web/templates",
        namespace: RumblWeb

      # Import convenience functions from controllers
      import Phoenix.Controller,
        only: [get_flash: 1, get_flash: 2, view_module: 1, view_template: 1]

      # Include shared imports and aliases for views
      unquote(view_helpers())
    end
  end

  def router do
    quote do
      use Phoenix.Router

      import Plug.Conn
      import Phoenix.Controller

      import Rumbl.Auth, only: [authenticate_user: 2]
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      alias Rumbl.Repo
      import RumblWeb.Gettext
      import Ecto
      import Ecto.Query
    end
  end

  defp view_helpers do
    quote do
      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      # Import basic rendering functionality (render, render_layout, etc)
      import Phoenix.View

      import RumblWeb.ErrorHelpers
      import RumblWeb.Gettext
      alias RumblWeb.Router.Helpers, as: Routes
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
