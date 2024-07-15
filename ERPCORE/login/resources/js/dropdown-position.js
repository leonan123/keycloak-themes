const dropdowns = document.querySelectorAll(".dropdown[data-dynamic='true']")

function handleDropdownPosition() {
  const dropdown = document.querySelector(".dropdown")
  const dropdownContent = dropdown.querySelector(".dropdown-content")
  
  if(!dropdownContent) return
  const dropdownReference = dropdown.previousElementSibling
  
  const rect = dropdownContent.getBoundingClientRect()
  const rectReference = dropdownReference.getBoundingClientRect()
  
  if(window.innerWidth < rect.right) {
    dropdown.dataset.placement = "left-bottom"
    return
  }

  if(window.innerWidth > rect.right + (rect.width - 50 / 100) + (rectReference.width / 2)) {
    dropdown.dataset.placement = "bottom"
  }
}

window.addEventListener("DOMContentLoaded", handleDropdownPosition)
window.addEventListener("resize", handleDropdownPosition)




