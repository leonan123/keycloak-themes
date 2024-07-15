const toggle = (button) =>  {
    const passwordElement = document.getElementById(button.getAttribute('aria-controls'));
    const icon = button.children.item(0)
    const iconPath = icon.src.split("/img")

    if (passwordElement.type === "password") {
        passwordElement.type = "text";
        
        iconPath[1] = button.dataset.iconHide
        icon.src = iconPath.join("");
        
        button.setAttribute("aria-label", button.dataset.labelHide);
    } else if(passwordElement.type === "text") {
        passwordElement.type = "password";

        iconPath[1] = button.dataset.iconShow
        icon.src = iconPath.join("");

        button.setAttribute("aria-label", button.dataset.labelShow);
    }
}

document.querySelectorAll('[data-password-toggle]')
    .forEach(button => button.onclick = () => toggle(button));