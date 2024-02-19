
Feature: Test Home Page
    
    Background: Define URL
        Given url 'https://conduit-api.bondaracademy.com/api'

    Scenario: Get all Tags
        Given path 'tags'
        When method Get
        Then status 200
        And match response.tags contains 'Test', 'YouTube'
        And match response.tags !contains 'cars'
        And match response.tags contains any ['Test', 'fish', 'dog']

        #And match response.tags contains only ['Test']
        And match response.tags == '#array'
        And match each response.tags response.tags == '#string'
        
    
    Scenario: Get 10 articles
        * def timeValidator = read('classpath:helpers/TimeValidator.js')
        Given params {limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles == '#[10]'
        And match response.articlesCount == 12
        And match response =={"articles": "#array", "articlesCount": 12}
        And match response.articles[0].createdAt contains '2024'
        And match response.articles[*].favoritesCount contains 1
        And match response.articles[*].author.bio contains null
        And match each response..following == false
        And match each response..following == '#boolean'
        And match each response..favoritesCount == '#number'
        And match each response..bio == '##string'
        And match each response.articles ==
        """
            {
                "slug": '#string',
                "title": '#string',
                "description": '#string',
                "body": '#string',
                "tagList": '#array',
                "createdAt": "#? timeValidator(_)",
                "updatedAt": "#? timeValidator(_)",
                "favorited": '#boolean',
                "favoritesCount": '#number',
                "author": {
                    "username": '#string',
                    "bio": '##string',
                    "image": '#string',
                    "following": '#boolean'
                }
            },
        """