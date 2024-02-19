Feature: Sign Up New User

    Background: Preconditions
        * def dataGenerator = Java.type('helpers.DataGenerators')
        Given url apiUrl

    @debug
    Scenario: New User
        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUsername()
        Given def userData = {email: "luchsf223s2o@test.com",  username: "fsdf3222s"}
        Given path 'users'
        And request
        """
            {user: {email: #(randomEmail), password: "Karat2eLucho", username: #(randomUsername)}}
        """
        When method Post
        Then status 201