<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false>
<!DOCTYPE html>
<html class="${properties.kcHtmlClass!}"<#if realm.internationalizationEnabled> lang="${locale.currentLanguageTag}"</#if>>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="robots" content="noindex, nofollow">

        <#if properties.meta?has_content>
            <#list properties.meta?split(' ') as meta>
                <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
            </#list>
        </#if>
        <title>${msg("loginTitle",(realm.displayName!''))}</title>
        <link rel="icon" href="${url.resourcesPath}/img/favicon.ico" />
        <#if properties.stylesCommon?has_content>
            <#list properties.stylesCommon?split(' ') as style>
                <link href="${url.resourcesCommonPath}/${style}" rel="stylesheet" />
            </#list>
        </#if>
        <#if properties.styles?has_content>
            <#list properties.styles?split(' ') as style>
                <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
            </#list>
        </#if>
        <#if properties.scripts?has_content>
            <#list properties.scripts?split(' ') as script>
                <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
            </#list>
        </#if>
        <script type="importmap">
            {
                "imports": {
                    "rfc4648": "${url.resourcesCommonPath}/node_modules/rfc4648/lib/rfc4648.js"
                }
            }
        </script>
        <script src="${url.resourcesPath}/js/menu-button-links.js" type="module"></script>

        <#if scripts??>
            <#list scripts as script>
                <script src="${script}" type="text/javascript"></script>
            </#list>
        </#if>
        <script type="module">
            import { checkCookiesAndSetTimer } from "${url.resourcesPath}/js/authChecker.js";

            checkCookiesAndSetTimer(
                "${url.ssoLoginInOtherTabsUrl?no_esc}"
            );
        </script>
    </head>

    <body>
        <header class="container">
            <img src="${url.resourcesPath}/img/logo.png" alt="" class="header-logo"/>
            
            <#if realm.internationalizationEnabled  && locale.supported?size gt 1>
                <div class="dropdown" id="kc-locale" data-placement="bottom" data-dynamic="true">
                    <button id="kc-current-locale-link" aria-label="${msg('languages')}" aria-haspopup="true" aria-expanded="false" aria-controls="language-switch1" tabindex="1" class="dropdown-reference">
                        <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M3.66406 4.47656C3.48047 4.51953 3.59766 4.51172 3.44531 4.53125C2.79297 4.67188 3.27734 4.79688 3.66406 4.47656ZM15.1367 4.73828C15.1836 4.70703 15.3477 4.54688 14.8359 4.39062C14.8672 4.55078 14.7305 4.53516 14.7305 4.625C15.1094 4.96875 15.2656 5.56641 15.75 5.69141C15.8438 5.26172 15.3203 5.05078 15.1367 4.73828ZM3.31641 4.35156C3.375 4.69922 3.63672 3.98438 3.64062 3.73047C3.53906 3.78906 3.4375 3.84766 3.33203 3.89453C3.57813 4.01953 3.36328 4.15234 3.09766 4.35156C2.55859 5.02344 3.60156 3.82812 3.31641 4.35156ZM10 0C4.47656 0 0 4.47656 0 10C0 15.5195 4.47656 20 10 20C15.5234 20 20 15.5195 20 10C20 4.47656 15.5234 0 10 0ZM10.2656 3.35156L10.3125 3.36719C10.125 3.60937 11.2891 4.31641 10.4531 4.375C9.67188 4.59766 10.7812 4.17188 10.1758 4.24609C10.4961 3.80078 9.92187 3.79297 10.2656 3.35156ZM5.52344 3.99219C5.24219 3.75781 4.35938 4.3125 4.66797 4.17969C5.43359 3.87891 4.71875 4.21094 4.89844 4.57031C4.73438 4.91016 4.84375 4.23438 4.4375 4.63672C4.14453 4.70312 3.42578 5.36719 3.51562 5.16406C3.49219 5.48047 2.66016 5.85547 2.54688 6.38281C2.27344 7.11328 2.48047 6.35547 2.42969 6.07031C2.03906 5.57422 1.32812 6.91016 1.53906 7.4375C1.89453 6.8125 1.86719 7.37109 1.60938 7.64844C1.87109 8.12891 1.37109 8.75391 1.86719 9.10938C2.08594 9.16016 2.52344 8.375 2.33203 9.19141C2.46484 8.48438 2.69922 9.35938 3.07812 9.16406C3.10156 9.53516 3.33203 9.36328 3.38281 9.8125C4.01562 9.76562 4.59375 10.8359 3.83984 11.0391C3.95313 11.0078 4.17578 11.207 4.43359 11.0547C4.87109 11.4023 6.02344 11.4453 6.05469 12.3047C5.26172 12.6836 5.85938 13.7227 5.17188 14.0938C4.38281 13.9766 4.90234 15.0664 4.57031 14.9414C4.70312 15.7266 3.77344 14.8398 4.13281 15.2734C4.79297 15.6797 3.84375 15.5977 4.14062 15.8945C3.80859 15.8242 4.34766 16.5117 4.4375 16.7656C4.91406 17.5391 4.02734 16.5938 3.76562 16.3359C3.51562 15.8359 2.92578 14.8789 2.76172 14.0938C2.66797 12.9531 1.78516 12.1875 1.58203 11.0742C1.37891 10.4531 2.14062 9.45703 1.73047 9.10938C1.375 8.83203 1.51953 7.88281 1.30859 7.38281C1.83594 5.09766 3.51172 3.17188 5.52344 2.03125C5.31641 2.18359 6.70703 1.63672 6.54688 1.76953C6.50391 1.86719 7.35938 1.39844 7.875 1.32812C7.82031 1.33594 6.53516 1.79688 6.89062 1.73438C6.33984 2.00391 6.83594 1.85156 7.10938 1.71484C6.5625 2.11719 6.14062 2.00391 5.51953 2.35938C4.89453 2.52344 5.02344 3.17188 4.57812 3.49609C4.83984 3.54297 5.49609 2.82031 5.87891 2.56641C6.75781 2.14062 5.43359 3.33984 6.26953 2.82422C5.98828 3.08594 6.04688 3.50391 5.875 3.62109C5.78906 3.59766 6.21484 3.82422 5.52344 3.99219ZM6.89062 2.19531C6.80078 2.31641 6.67578 2.57812 6.60156 2.41797C6.5 2.46875 6.46094 2.6875 6.26953 2.51172C6.38281 2.42969 6.5 2.23438 6.27734 2.35547C6.37891 2.24609 7.28516 1.9375 7.23438 1.82031C7.39453 1.71875 7.37891 1.66797 7.19531 1.73047C7.10156 1.69922 7.41797 1.43359 7.83984 1.39844C7.89844 1.39844 7.92188 1.4375 7.81641 1.42578C7.17969 1.62109 7.45312 1.56641 7.88281 1.42578C7.71875 1.51953 7.60547 1.54688 7.57812 1.58984C8.00781 1.43359 7.55469 1.70312 7.65234 1.68359C7.53125 1.74609 7.67188 1.76562 7.4375 1.85547C7.48047 1.82031 7.05469 2.10938 7.30859 2.02344C7.0625 2.25781 6.95312 2.26172 6.89062 2.19531ZM7.26562 2.75391C7.27344 2.37891 7.8125 2.14062 7.74609 2.12109C8.41016 1.80859 7.51562 2.13281 8.03906 1.85156C8.23438 1.83203 8.64844 1.20703 9.22266 1.16797C9.85547 0.976562 9.5625 1.17969 10.0312 1L9.9375 1.07812C9.85547 1.08984 9.95703 1.23438 9.66016 1.45312C9.62891 1.79297 9.09375 1.63672 9.35938 2C9.1875 1.75391 8.92969 1.99219 9.25391 2.01562C8.90625 2.28125 8.09766 2.32812 7.71094 2.76953C7.46094 3.12891 7.23047 3.01562 7.26562 2.75391ZM10.043 4.00391C9.77734 4.64453 9.51953 3.91016 9.98828 3.79297C10.1055 3.85547 10.1523 3.875 10.043 4.00391ZM9.04297 2.72266C8.96484 2.43359 9.02734 2.58594 9.49219 2.44922C9.8125 2.67969 9.20703 2.83203 9.04297 2.72266ZM16.3164 14.1875C15.9492 13.5547 16.7617 12.9688 17.0352 12.4375C17 13.0586 16.9219 13.6719 16.3164 14.1875ZM17.6992 6.95703C17.3008 6.98828 16.9414 7.08203 16.582 6.85547C15.7539 5.94922 16.7344 7.87891 17.0078 7.08984C17.9922 7.46484 16.9922 9.08203 16.3711 8.91406C16.0234 8.16406 15.5937 7.33984 14.8359 6.97266C15.418 7.61719 15.707 8.41016 16.332 8.99219C16.375 9.80469 17.1992 8.69531 17.1484 9.32422C17.2266 10.4062 15.9258 11.0547 16.1523 12.1406C16.6367 13.1289 15.2188 13.3086 15.3789 14.1953C14.8086 14.832 14.1992 15.6914 13.1758 15.5547C13.1758 15.0156 12.9023 14.5586 12.8398 14.0039C12.2852 13.3008 13.4258 12.5469 12.7188 11.8125C11.9023 11.6289 12.8867 10.5039 12.0469 10.6094C11.543 10.1055 10.8047 10.5937 10.082 10.5977C9.17578 10.6836 8.24219 9.48438 8.64453 8.63672C8.32422 7.75391 9.66016 7.49609 9.69531 6.71875C10.3359 6.18359 11.2461 6.25 12.1133 6.125C12.0508 6.74609 12.707 6.75 13.2031 6.95703C13.4805 6.28516 14.3437 7.06641 14.9336 6.64062C15.1367 5.64844 14.3594 6.24609 13.9141 5.92969C13.375 5.14062 15.0664 5.52344 14.8906 5.10938C14.2344 5.10547 14.6055 4.30078 14.1406 4.75C14.5586 4.82422 14.0664 5.15234 14.0781 4.77734C13.4453 4.59375 14.0547 5.49609 13.7344 5.58203C13.2461 5.37891 13.4766 5.8125 13.5273 5.87891C13.3164 6.33594 13.0586 5.20703 12.4609 5.23828C11.8672 4.69531 12.2266 5.48438 12.7422 5.61328C12.6328 5.64453 12.8047 6.09375 12.668 5.90234C12.2422 5.31641 11.4336 4.92578 10.9531 5.64453C10.9023 6.31641 9.53516 6.50781 9.75391 5.72266C9.43359 4.91016 10.7461 5.69922 10.625 5.05078C9.78125 4.49219 10.8555 4.67188 11.1406 4.14844C11.7891 4.16797 11.168 3.61719 11.4727 3.45703C11.4414 4.05469 11.9688 3.94141 12.3867 3.82812C12.2852 3.48438 12.6367 3.49609 12.4219 3.21094C13.3906 2.82422 11.6836 3.39062 12.0273 2.54297C11.6094 2.25391 11.8516 3.17969 12.0273 3.27734C12.0391 3.5625 11.7969 3.91406 11.4648 3.31641C10.9805 3.63281 11.0312 2.99609 11 3.0625C10.9453 2.81641 11.3672 2.80469 11.3711 2.375C11.3359 2.10156 11.3438 1.95703 11.5391 1.94141C11.5547 1.98047 12.3398 1.99219 12.6172 2.31641C11.8594 2.16406 12.5039 2.44141 12.8438 2.59766C12.4805 2.3125 12.9883 2.59766 12.6914 2.27344C12.8086 2.29688 12.3672 1.82812 12.8203 2.23828C12.5742 1.94531 13.3008 2.03125 12.8711 1.8125C13.5 1.98828 13.1289 1.82812 12.7578 1.66797C11.7344 1.05859 14.5664 2.49219 13.4102 1.85547C14.1484 2.01562 11.832 1.28516 12.8867 1.60547C12.4844 1.42969 12.875 1.52734 13.2383 1.64062C12.5859 1.4375 11.6094 1.05859 11.6484 1.04297C11.875 1.05859 12.0977 1.10938 12.3125 1.17188C12.9805 1.37109 12.1211 1.125 12.3047 1.12891C14.6016 1.71875 16.6133 3.25781 17.8359 5.26953C18.1211 5.57031 18.8984 7.55859 18.4922 6.67578C18.6758 7.37891 18.7031 8.13672 18.8008 8.85547C18.5977 8.62891 18.3711 7.79297 18.1758 7.32812C18.0938 7.50781 18 7.07422 17.6992 6.95703Z" fill="#666666"/>
                        </svg>
                        <span>${locale.current}</span>
                    </button>
                    <div class="dropdown-content">
                        <ul role="menu" aria-labelledby="kc-current-locale-link" aria-activedescendant="" id="language-switch1">
                            <#assign i = 1>
                            <#list locale.supported as l>
                                <li role="none">
                                    <a role="menuitem" id="language-${i}" href="${l.url}" tabindex="${i + 1}">${l.label}</a>
                                </li>
                                <#assign i++>
                            </#list>
                        </ul>
                    </div>
                </div>
            </#if>
        </header>
        
        <main>
            <div class="brand-wrapper">
                <div class="brand">
                    <img src="${url.resourcesPath}/img/erp-core-logo.svg" alt="ERP CORE" />
                    <h2>${kcSanitize(msg("brand-description",(realm.displayNameHtml!'')))?no_esc}</h2>
                </div>
            </div>
            
            <div class="login-wrapper"> 
                <div class="login">
                    <div class="login-form">
                        <#nested "header">

                        <#if displayInfo>
                            <#nested "info">
                        </#if>
                        
                        <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
                            <div class="alert alert-${message.type} flex items-start mt-3_5">
                                <div class="alert-icon">
                                    <#if message.type = 'success'><img src="${url.resourcesPath}/img/icon-success.svg" /></#if>
                                    <#if message.type = 'warning'><img src="${url.resourcesPath}/img/icon-warning.svg" /></#if>
                                    <#if message.type = 'error'><img src="${url.resourcesPath}/img/icon-error.svg" /></#if>
                                    <#if message.type = 'info'><img src="${url.resourcesPath}/img/icon-info.svg" /></#if>
                                </div>
                                <p class="alert-description">${kcSanitize(message.summary)?no_esc}</p>
                            </div>
                        </#if>

                        <#nested "form">

                        <#if auth?has_content && auth.showTryAnotherWayLink()>
                            <form id="kc-select-try-another-way-form" action="${url.loginAction}" method="post">
                            <div>
                                <input type="hidden" name="tryAnotherWay" value="on"/>
                                <a href="#" id="try-another-way"
                                    onclick="document.forms['kc-select-try-another-way-form'].submit();return false;">${msg("doTryAnotherWay")}</a>
                                </div>
                            </form>
                        </#if>

                        <#nested "socialProviders">
                    </div>
                </div>
            </div>
        </main>

        <script type="module" src="${url.resourcesPath}/js/dropdown-position.js"></script>
    </body>
</html>
</#macro>
