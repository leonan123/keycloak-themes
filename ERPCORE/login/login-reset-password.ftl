<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true displayMessage=!messagesPerField.existsError('username'); section>
    <#if section = "header">
        <h1 class="heading-1">${msg("emailForgotTitle")}</h1>
    <#elseif section = "info">
        <p class="mt-12 reset-password-instruction">
            <#if realm.duplicateEmailsAllowed>
                ${msg("emailInstructionUsername")}
            <#else>
                ${msg("emailInstruction")}
            </#if>
        <p>
    <#elseif section = "form">
        <form id="kc-reset-password-form" action="${url.loginAction}" method="post" class="mt-12" has-validations>
            <div class="form-group">
                <label for="username">
                    <#if !realm.loginWithEmailAllowed>${msg("username")}
                        <#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}
                        <#else> ${msg("email")}
                    </#if>
                </label>
                <input type="text" id="username" name="username" class="input" value="${(auth.attemptedUsername!'')}" autofocus
                    aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"
                    data-is-email="<#if realm.loginWithEmailAllowed && realm.registrationEmailAsUsername>true</#if>"
                />
                <span id="input-error-username" class="input-error-message mt-1 <#if !messagesPerField.existsError('username')>hidden</#if>" aria-live="polite">
                    <#if messagesPerField.existsError('username')> 
                        ${kcSanitize(messagesPerField.get('username'))?no_esc}
                    </#if>
                </span>
            </div>
            <div class="mt-10">
                <button class="button button-primary" type="submit">
                    ${msg("doSubmit")}
                </button>

                <a href="${url.loginUrl}" class="link link-primary mt-5 w-full">${kcSanitize(msg("backToLogin"))?no_esc}</a>
            </div>
        </form>
        <script type="module" src="${url.resourcesPath}/js/validations.js"></script>
    </#if>
</@layout.registrationLayout>
