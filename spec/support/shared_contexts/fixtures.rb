shared_context 'fixtures' do
  let(:public_address) { '0xcd00510fBb8aBe8c2e9A48101247C6FaF8E10ec2'.downcase }
  let(:user) do
    User.create(
      email: 'an@user.com',
      password: 'password',
      public_address: public_address
    )
  end
end
