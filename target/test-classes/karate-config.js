function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {

    apiUrl: 'https://conduit-api.bondaracademy.com/api'
  }
  if (env == 'dev') {
    config.userEmail = 'lucho@test.com'
    config.userPassword = 'KarateLucho'

  } else if (env == 'qa') {

    config.userEmail = 'lucho2@test.com'
    config.userPassword = 'KarateLucho2'
  }

  var accessToken = karate.callSingle('classpath:helpers/CreateToken.feature', config).authToken
  karate.configurer('headers', {Authorization: 'Token '+ accessToken})
  return config;
}