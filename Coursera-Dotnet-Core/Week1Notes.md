# Contents

[Weakly Typed Forms](#weakly-typed-forms)

# Weakly Typed Forms

`AccountController.cs`
```csharp
using Microsoft.AspNetCore.Mvc;
namespace coreFormsAndValidations.Controllers
{
    public class AccountController : Controller {
        public IActionResult WeaklyTypedLogin() 
        {
            return View();
        }

        [HttpPost]
        public IActionResult LoginPost(string username, string password)
        {
            ViewBag.Username = username;
            ViewBag.Password = password;
            return View();
        }

        public IActionResult StronglyTypedLogin()
        {
            return View();
        }

        [HttpPost]
        public IActionResult LoginSuccess(LoginViewModel login)
        {
            if(login.Username != null && login.Password !=null)
            {
                if (login.Username.Equals("admin") && login.Password.Equals("admin"))
                {
                    ViewBag.Message = "You are successfully logged in";
                    return View();
                }
            }

            else {
                ViewBag.Message = "Invalid Credentials";
                return View();
            }
        }

        public IActionResult UserList()
        {
            var users = new List<LoginViewModel>()
            {
                new LoginViewModel(){ Username="User1", Password="123456"};
                new LoginViewModel(){ Username="User2", Password="123456"};
                new LoginViewModel(){ Username="User3", Password="123456"};

            };
            return View(users);
        }

        public IActionResult GetAccount()
        {
            return View();

        }

        [HttpPost]
        public IActionResult PostAccount(Account account)
        {
            if (ModelState.IsValid) 
            {
                return View("Success");
            }
            return RedirectToAction("GetAccount");
        }

    }
}

```
`WeaklyTypedLogin.cshtml`
```html
<html>
<head>
    <title>WeaklyTypedLogin</title>
</head>
<body>
    @using(Html.BeginForm) 
    {
        <div>
            Username: @Html.TextBox("UserName")
        </div>
        <div>
            Password: @Html.TextBox("Password")
        </div>
        <div>
            <input type="submit" value="Login"/>
        </div>
    }
</body>
```

# Form Validations

`Models/Account.cs`

```csharp
using System.ComponentModel.DataAnnotations;
namespace coreFormsAndValidations.Models 
{
    public class Account
    {
        [Required]
        [MinLength(5)]
        [MaxLength(15)]
        public string? Username { get; set; }

        [Required]
        [MinLength(8)]
        [MaxLength(15)]
        public string? Password { get; set; }

        [Range(18,60)]
        public int Age { get; set }

        [Required]
        [EmailAddress]
        public string? Email { get; set; }

        [Url]
        public string? Website {get; set; }
    }
}
```

`GetAccount.cshtml`
```html

```

`Success.cshtml`
```html

```

`StronglyTypedLogin.cshtml`
```html
@model coreFormsAndValidations.Models.LoginViewModel

@{
    Layout = null;
}
<html>
<head>
    <title>StronglyTypedLogin</title>
</head>
<body>
    @using(Html.BeginForm("LoginSuccess", "Account", FormMethod.Post))
    {
        <div>
            Username: @Html.TextBoxFor(m => m.Username)
        </div>
        <div>
            Password: @Html.PasswordFor(m => m.Password)
        </div>
        <div>
            <input type="submit" value="Login">
        </div>
    }
</body>
</html>
```