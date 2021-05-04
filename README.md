# CombineTest
A simple test on Combine's throttle operator.

Related to the issue in RxSwift: https://github.com/ReactiveX/RxSwift/issues/2316

Steps:

1. run the app.
2. tap the buttons a few times to make sure subscription is working.
3. change device time to an earlier date, say, yesterday.
4. come back to tap the buttons again.
5. will see: Combine button still fires but RxSwift button does not.
6. now change time back to present and tap the buttons again: both should be working.
