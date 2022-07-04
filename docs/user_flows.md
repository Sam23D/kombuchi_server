# User flows
Here we describe the common flows a user can have in our application, there give a view of how the user/client interacts with the apps modules and protocols

- Registration / Subscription
- Password Reset


- Delete account

### Subscription / Registration
Here the user provides their email and name, a user and a subscription entity will be created, the user will not be active by default.
A verification email is triggered and sent to the user's provided email, to verify both account and subscribe(contact)
<div class="mermaid">
sequenceDiagram;
actor User;
User->>UserRegisterController: POST /users/register;
Note right of User: {name: str, email: str};
UserRegisterController->>UserRegisterController: Create user & subscribe;
UserRegisterController-->>Accounts: :deliver_user_confirmation_instructions;
UserRegisterController->>User: render "user_created";
Accounts-->>User: Send user confirmation email;
User->>UserConfirmationController: GET /users/confirm/:token;
UserConfirmationController->>Accounts: :confirm_user;
UserConfirmationController->>User: render "User confirmed";
</div>

### Password reset
The user can select from the login page i forgot my password wich will redirect him to the user reset password page, where he can insert his email, and a token will be notified by email, with the token she can create a new password for his account. 


<div class="mermaid">
sequenceDiagram;
actor User;
User->>UserRegisterController: GET /users/reset_password;
Note right of User: {name: str, email: str};
UserRegisterController->>UserRegisterController: Create user & subscribe;
UserRegisterController-->>Accounts: :deliver_user_confirmation_instructions;
UserRegisterController->>User: render "user_created";
Accounts-->>User: Send user confirmation email;
User->>UserConfirmationController: GET /users/confirm/:token;
UserConfirmationController->>Accounts: :confirm_user;
UserConfirmationController->>User: render "User confirmed";
</div>

### Delete account
The user can select to delete his account and all the information