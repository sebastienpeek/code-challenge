Code Challenge - Lucky Day
================
# What is this?

Implementation of a simple iOS trivia game which fetches True/False trivia questions from Open Trivia DB and allows the user to play.

### Brief Walkthrough

The application is divided into four groups within the project. This includes Controllers, Helpers, Models and Modules. The decision to divide the application allows for easy navigating when working in certain areas of an application.

In controllers you will find there is a MainViewController and a QuestionViewController. The MainViewController is responsible for generating QuestionViewController's based off of the response from the API. The MainViewController is utilizing a UIScrollView containing a Horizontal UIStackView, which the MainViewController adds generated QuestionViewController's into. This enables all logic for the individual question component to be contained within the QuestionViewController.

The QuestionViewController has a delegate which will be the MainViewController. This enables us to inform the MainViewController when two things occur, the user got the answer correct or incorrect. The MainViewController then reacts depending on what delegate callback has occurred.

The MainViewController also handles pagination. If the user has answered the total amount of questions available correct, we will then fetch the next 10.

On an incorrect answer, the MainViewController will show a results view. This is using UserDefaults to save the highest score and display it, as well as there last games score. The user can then restart the game from here.

#### RESTful Component

Under `Modules -> API` you will find the overall arching `OTApiManager` which utilizes Alamofire to handle requests that are passed via managers.

#### Managers

I believe that managers for individual collections of actions that are handled should be specced out separately. This allows the testing of these components with ease.

You will find a single manager in this project, the `QuestionManager` which has a single function (`get(with params: GenericDictionary, @escaping ApiManagerCompletionHandler)`) which utilizes a router to build up the request and then handles the success and error response.

On success, this function is defensive in getting the data it is required, it then builds up an array of `Question` models and returns the success and array to the completion handler.

#### Routers

Routers are merely a way of having finite control over a single or multiple API requests. I lean to the favor that one router should be used for each manager. This keeps code clean and concise.

The `QuestionRouter` is an `enum` that is a subclass of a `URLRequestConvertible` provided to us by Alamofire. Here we can set, depending on the case, the method and path required as well as any other components within the `asURLRequest()` function.

### Setup Local

My implementation of this requires the use of CocoaPods to allow the utilization of Alamofire. CocoaPods should never be included in a repository as it creates overhead within the repository and will most often than not hurt the teams productivity due to conflicts.

To get started:

`git clone git@github.com:sebastienpeek/code-challenge.git`

`cd code-challenge`

`pod install`

Once you have run the last command, you can then open `CodeChallenge.xcworkspace` and run on the Simulator. If you require the ability to run on device, you will have to open the `CodeChallenge` target and set the appropriate team under `Signing`.