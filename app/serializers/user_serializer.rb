class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :name, :avatar_url
end
