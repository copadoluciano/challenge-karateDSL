Feature: Test Home Page
    
    Background: Define URL
        Given url 'https://conduit-api.bondaracademy.com/api'

    Scenario: Get all Tags
        Given path 'tags'
        When method Get
        Then status 200
        And match response.tags contains 'Test', 'Zoom'
        And match response.tags !contains 'cars'
        And match response.tags == '#array'
        And match each response.tags response.tags == '#string'
        
    @debug
    Scenario: Get 10 articles
        Given params {limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles == '#[10]'
        And match response.articlesCount == 10