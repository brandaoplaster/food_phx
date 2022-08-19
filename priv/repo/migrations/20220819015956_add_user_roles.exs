defmodule FoodPhx.Repo.Migrations.AddUserRoles do
  use Ecto.Migration

  def change do
    create = "CREATE TYPE roles as ENUM ('USER', 'ADMIN')"
    drop = "DROP TYPE roles"

    execute(create, drop)

    alter table(:users) do
      add :role, :roles, default: "USER", null: false
    end
  end
end
