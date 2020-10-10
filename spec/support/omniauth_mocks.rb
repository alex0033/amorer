module OmniauthMocks
  def facebook_mock(user)
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      provider: 'facebook',
      uid: user.uid,
      info: {
        email: user.email,
        name: user.name,
        first_name: 'Joe',
        last_name: 'Bloggs',
        image: 'http://graph.facebook.com/1234567/picture?type=square',
        verified: true,
      },
      credentials: {
        token: 'ABCDEF...',
        expires_at: 1321747205,
        expires: true,
      },
      extra: {
        raw_info: {
          id: user.uid,
          name: user.name,
          first_name: 'Joe',
          last_name: 'Bloggs',
          link: 'http://www.facebook.com/jbloggs',
          username: 'jbloggs',
          location: { id: '123456789', name: 'Palo Alto, California' },
          gender: 'male',
          email: 'joe@bloggs.com',
          timezone: -8,
          locale: 'en_US',
          verified: true,
          updated_time: '2011-11-11T06:21:03+0000',
        },
      },
    })
  end

  def facebook_invalid_mock(user)
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      provider: '',
      uid: '',
      info: {
        email: user.email,
        name: user.name,
        first_name: 'Joe',
        last_name: 'Bloggs',
        image: 'http://graph.facebook.com/1234567/picture?type=square',
        verified: true,
      },
      credentials: {
        token: 'ABCDEF...',
        expires_at: 1321747205,
        expires: true,
      },
      extra: {
        raw_info: {
          id: '',
          name: user.name,
          first_name: 'Joe',
          last_name: 'Bloggs',
          link: 'http://www.facebook.com/jbloggs',
          username: 'jbloggs',
          location: { id: '123456789', name: 'Palo Alto, California' },
          gender: 'male',
          email: 'joe@bloggs.com',
          timezone: -8,
          locale: 'en_US',
          verified: true,
          updated_time: '2011-11-11T06:21:03+0000',
        },
      },
    })
  end
end
