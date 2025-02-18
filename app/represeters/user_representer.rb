class UserRepresenter
  def initialize(users)
    @users = users
  end

  def as_json
    users.map do |user|
      {
        id: user.id,
        name: user.name,
        email: user.email,
        corporation_id: user.corporation&.id,
        corporation_name: user.corporation&.name,
      }
    end
  end

  private

  attr_reader :users
end