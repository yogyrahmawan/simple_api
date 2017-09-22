def User do 
  use Ecto.Schema
  import Ecto.Changeset
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  schema "users" do 
    field :first_name, :string 
    field :last_name, :string 
    field :address, :string
    field :username, :string
    field :encrypted_password, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, :virtual: true
  end 

  @required_fields ~w(username email password password_confirmation)
  @optional_fields ~w()
  
  def changeset(user, params \\ :empty) do 
    user 
    |> cast(params, @required_fields, @optional_fields)
    |> validate_password()
    |> unique_constraint(:username, :email)
    |> put_change(:encrypted_password, hashpwsalt(params[:password]))
  end 

  defp validate_password(changeset) do 
    case get_chage(changeset, :password_confirmation) do 
      nil -> add_error(changeset, :password, "is not valid")
      confirmation -> 
        password = get_change(changeset, :password)
        if confirmation == password do 
          changeset 
        else
          add_error(changeset, :password, "not match")
        end
    end 
  end
end
