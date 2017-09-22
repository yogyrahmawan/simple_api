defmodule SimpleApi.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do 
      add :first_name, :string 
      add :last_name, :string 
      add :address, :string
      add :username, :string, unique: true
      add :encrypted_password, :string, null: false
      add :email, :string

      timestamps
    end 

    create unique_index(:users, [:username], name: :unique_usernames)
  end
end
