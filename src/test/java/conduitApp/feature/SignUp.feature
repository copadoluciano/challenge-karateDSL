Feature: Sign Up New User

    Background: Preconditions
        * def dataGenerator = Java.type('helpers.DataGenerators')
        Given url apiUrl

    
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

  
        Scenario Outline: Validate Sign Up Messages

            * def randomEmail = dataGenerator.getRandomEmail()
            * def randomUsername = dataGenerator.getRandomUsername()

            Given path 'users'
            And request
            """
                {user: {email: "<email>", password: "<password>", username: "<username>"}}
            """
            When method Post
            Then status 422
            And match response == <errorResponse>

            Examples:
                | email | password | username | errorResponse | 
                | #(randomEmail) | Karate123 | KarateLucho | {"errors":{"username":["has already been taken"]}} | 
        | KarateLucho@test.com | Karate123 | #(randomUsername) |{"errors":{"email":["has already been taken"]}} | 


        