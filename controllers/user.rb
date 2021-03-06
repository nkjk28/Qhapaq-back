# ユーザのログイン用
post '/user/sign_in' do
  user_params = JSON.parse(request.body.read)
  user = User.find_by(name: user_params['name'])
  if user && user.authenticate(user_params['password'])
    token = UserToken.create(
      user_id: user.id,
      uuid: SecureRandom.uuid,
      expiration_time: Time.zone.now.since(1.hours)
    )
    {user: {name: user.name}, token: token.uuid }.to_json
  else
    status 400
  end
end

# ユーザーの作成用
post '/user/sign_up/:token' do
  #TODO
  #ユーザーのアカウント作成はAdminアカウントからのユーザー作成用URLを発行し、
  #そのURLから一定時間以内はアカウントを作れるようにする
end
