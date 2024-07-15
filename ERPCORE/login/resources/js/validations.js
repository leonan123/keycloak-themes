const forms = document.querySelectorAll("form[has-validations]");

forms.forEach(form => { 
  const inputUsername = form.querySelector("input#username[data-is-email='true']")
  const inputPassword = form.querySelector("input#password-new")

  inputUsername && inputUsername.addEventListener("blur", () => validateInput(inputUsername.id))
  inputPassword && inputPassword.addEventListener("keyup", () => validateInput(inputPassword.id))

  form.addEventListener("submit", ev => { 
    const formData = new FormData(form);
    let isValid = true

    for (const [key] of formData) {      
      if(!validateInput(key)) {
        isValid = false
      }
    }

    if(!isValid) {
      ev.preventDefault()
      return
    }
  })
})

/**
 * @param {string} inputId 
 * @returns {boolean} isValid
 */
function validateInput(inputId) { 
  const input = document.querySelector(`input#${inputId}`)
  
  if(!input) return false

  let isValid = true

  switch(input.id) {
    case "username":
      const isEmailInput = input.dataset.isEmail === "true"

      if(isEmailInput && input.value.length && !emailIsValid(input.value)) {
        setErrorMessage(input, "invalidEmail")
        isValid = false
      }
      
      break;

    case "password-new":
      isValid = passwordValidation(input)
    break;
  }

  if(isValid && input.type !== "checkbox") {
    input.parentElement.querySelector(".input-error-message").classList.add("hidden")
    input.ariaInvalid = false
  }

  return isValid
}

/**
 * Validate password
 * @param {HTMLInputElement} input 
 * @returns {boolean}
 */
function passwordValidation(input) {
  const password = input.value
  const patterns = {
    lowerCaseLetters: /[a-z]/g,
    upperCaseLetters: /[A-Z]/g,
    numbers: /[0-9]/g,
    specialCharacters: /[^A-Za-z0-9]/g
  }

  let isValid = []
  
  for (const pattern of Object.keys(patterns)) {
    const errorDescription = document.querySelector(`#password-messages > #${pattern}`) 
    
    if(!password.match(patterns[pattern])) {
      if (errorDescription) { 
        errorDescription.classList.remove("valid")
        errorDescription.classList.add("invalid")
      }

      isValid.push(false)
      continue
    }
    
    if (errorDescription) {
      errorDescription.classList.add("valid")
      errorDescription.classList.remove("invalid")
    }
  }

  const errorDescription = document.querySelector(`#password-messages > #minLength`) 
  
  if(password.length < 12) {

    if (errorDescription) {
      errorDescription.classList.remove("valid")
      errorDescription.classList.add("invalid")
    }

    isValid.push(false)
  } else { 
    if (errorDescription) {
      errorDescription.classList.remove("invalid")
      errorDescription.classList.add("valid")
    }
  }


  return !isValid.length
}

/**
 * Translate error message
 * @param {string} messageKey
 * @returns {string}
*/

function translateErrorMessage(messageKey) {
  const currentLanguage = document.querySelector("html").lang

  const translates = {
    "pt-BR": {
      "invalidEmail": "Formato do email inválido.",
    },
    "en": {
      "invalidEmail": "Invalid email format.",
    },
    "es": {
      "invalidEmail": "Formato de correo inválido.",
    },
  }
  
  if(!translates[currentLanguage]) {
    return translates["pt-BR"][messageKey]
  }

  return translates[currentLanguage][messageKey]
}

/**
 * Set error message
 * @param {HTMLInputElement} input
 * @param {string} messageKey
 */
function setErrorMessage(input, messageKey) {
  const messageTranslated = translateErrorMessage(messageKey) 
  const errorMessageElement =  input.parentElement.querySelector(".input-error-message")
  
  input.ariaInvalid = true
  
  errorMessageElement.classList.add("hidden")
  errorMessageElement.innerText = messageTranslated
  errorMessageElement.classList.remove("hidden")
}

/**
 * @param {string} email
 */
function emailIsValid(email) {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)
}