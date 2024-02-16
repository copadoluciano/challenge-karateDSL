Feature: Articles

    Background: Define URL
        Given url 'https://conduit-api.bondaracademy.com/api'


    Scenario: Create new article
        Given path "users/login"
        And request {"user": {"email": "lucho@test.com", "password": "KarateLucho"}}
        When method Post
        Then status 200
        * def token = response.user.token


        Given header Authorization = 'Token ' + token
        Given path 'articles'
        And request {"article":{"title": "hello1", "description": "bla bla", "body": "2", "tagList": []}}
        When method Post 
        Then status 201
        And match response.article.title == 'hello1'

