Feature: Articles

    Background: Define URL
        Given url apiUrl


    # Scenario: Create new article
    #     Given path "users/login"
    #     And request {"user": {"email": "lucho@test.com", "password": "KarateLucho"}}
    #     When method Post
    #     Then status 200
    #     * def token = response.user.token
    * def tokenResponse = callonce read('classpath:helpers/CreateToken.feature') 
    * def token = tokenResponse.authToken


    #     Given header Authorization = 'Token ' + token
    #     Given path 'articles'
    #     And request {"article":{"title": "aa", "description": "bla bla", "body": "2", "tagList": []}}
    #     When method Post
    #     Then status 201
    #     And match response.article.title == 'hello1'

    @debug
    Scenario: Create and Delete article
        Given path "users/login"
        And request {"user": {"email": "lucho@test.com", "password": "KarateLucho"}}
        When method Post
        Then status 200
        * def token = response.user.token

        # Given header Authorization = "Token " + token # reemplazado por accessToken en karate-config
        Given path 'articles'
        And request {"article":{"title": "Delete Article", "description": "bla bla", "body": "2", "tagList": []}}
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

