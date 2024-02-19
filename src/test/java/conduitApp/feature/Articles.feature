Feature: Articles

    Background: Define URL
        * url apiUrl
        * def articleRequestBody = read('classpath:conduitapp/json/newArticleRequest.json')
        * def dataGenerator = Java.type('helpers.DataGenerators')
        * set articleRequestBody.article.title = dataGenerator.getRandomArticleValues().title
        * set articleRequestBody.article.description = dataGenerator.getRandomArticleValues().description
        * set articleRequestBody.article.body = dataGenerator.getRandomArticleValues().body



    # Scenario: Create new article
    #     Given path "users/login"
    #     And request {"user": {"email": "lucho@test.com", "password": "KarateLucho"}}
    #     When method Post
    #     Then status 200
    #     * def token = response.user.token
    * def tokenResponse = callonce read('classpath:helpers/CreateToken.feature') 
    * def token = tokenResponse.authToken



        Given path 'articles'
        And request articleRequestBody
        When method Post
        Then status 201
        And match response.article.title == articleRequestBody.article.title

    @debug
    Scenario: Create and Delete article
        Given path "users/login"
        And request {"user": {"email": "lucho@test.com", "password": "KarateLucho"}}
        When method Post
        Then status 200
        * def token = response.user.token

        # Given header Authorization = "Token " + token # reemplazado por accessToken en karate-config
        Given path 'articles'
        And request articleRequestBody
        When method Post
        Then status 201
        * def articleId = response.article.slug

        Given params {limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        # And match response.articles[0].title == 'Delete Article'

        # Given header Authorization = "Token " + token # reemplazado por accessToken en karate-config
        Given path 'articles',articleId
        When method Delete
        Then status 204

        Given params {limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title != 'Delete Article'

