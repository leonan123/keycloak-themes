<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
<#if section = "header">
<h1 class="heading-1">${msg("loginAccountTitle")}</h1>

<#elseif section = "info" >
<#if realm.password && realm.registrationAllowed && !registrationDisabled??>
    <#--  href="${url.registrationUrl}"   -->
    <p class="login-no-account-description mt-3_5">${msg("noAccount")} <a tabindex="8" class="link link-primary" aria-disabled="true" disabled>${msg("doRegister")}</a></p>
</#if>
<#elseif section = "form">
<div id="kc-form">
    <div id="kc-form-wrapper">
        <#if realm.password>
            <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post" class="mt-7">
                <#if messagesPerField.existsError('username','password')>
                    <span id="input-error" class="error-message mb-3_5" aria-live="polite">
                        ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                    </span>
                </#if>
                
                <#if !usernameHidden??>
                    <div class="form-group">
                        <label for="username"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>

                        <input id="username" class="input" name="username" value="${(login.username!'')}" type="text" autofocus autocomplete="username"
                            aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                        />
                    </div>
                </#if>

                <div class="form-group">
                    <label for="password" class="${properties.kcLabelClass!}">${msg("password")}</label>

                    <div class="input-password-container">
                        <input id="password" class="input" name="password" type="password" autocomplete="current-password" placeholder="${msg('password')}"
                                aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                        />
                        <button class="password-visibility-button" type="button" aria-label="${msg('showPassword')}"
                                aria-controls="password" data-password-toggle
                                data-icon-show="/img/icon-show-password.svg" data-icon-hide="/img/icon-hide-password.svg"
                                data-label-show="${msg('showPassword')}" data-label-hide="${msg('hidePassword')}"
                                tabindex="-1">
                            <img src="${url.resourcesPath}/img/icon-show-password.svg" />
                        </button>
                    </div>

                    <#if usernameHidden?? && messagesPerField.existsError('username','password')>
                        <span id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                        </span>
                    </#if>

                </div>

                <div class="form-options">
                    <#if realm.rememberMe && !usernameHidden??>
                        <div class="form-group">
                            <label class="checkbox-label">
                                <#if login.rememberMe??>
                                    <input id="rememberMe" name="rememberMe" type="checkbox" checked>
                                <#else>
                                    <input id="rememberMe" name="rememberMe" type="checkbox">
                                </#if>

                                <span class="checkbox"></span>
                                ${msg("rememberMe")}
                            </label>
                        </div>
                    </#if>
                    <div>
                        <#if realm.resetPasswordAllowed>
                            <span>
                                <a href="${url.loginResetCredentialsUrl}" class="link link-secondary">${msg("doForgotPassword")}</a>
                            </span>
                        </#if>
                    </div>
                </div>

                <div id="kc-form-buttons" class="form-group mt-6">
                    <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                    <button class="button button-primary" id="kc-login" type="submit">
                        ${msg("doLogIn")}
                    </button>
                </div>
            </form>
        </#if>
    </div>
</div>
<script type="module" src="${url.resourcesPath}/js/passwordVisibility.js"></script>

<#elseif section = "info" >

    <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
        <div id="kc-registration-container">
            <div id="kc-registration">
                <span>${msg("noAccount")} <a tabindex="8" href="${url.registrationUrl}">${msg("doRegister")}</a></span>
            </div>
        </div>
    </#if>

<#elseif section = "socialProviders" >

    <#if realm.password && social?? && social.providers?has_content>
        <div id="kc-social-providers" class="form-social-login mt-6">
            <h3>${msg("identity-provider-login-label")}</h3>

            <ul class="form-social-login-list <#if social.providers?size gt 3>${properties.kcFormSocialAccountListGridClass!}</#if>">
                <#list social.providers as p>
                    <li>
                        <a id="social-${p.alias}" class='button button-${p.alias}-provider' type="button" href="${p.loginUrl}">
                            <img src="${url.resourcesPath}/img/icon-${p.alias}.svg" alt="${p.displayName}"/>
                            <#if p.iconClasses?has_content>
                                <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!}" aria-hidden="true"></i>
                                <span class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text">${p.displayName!}</span>
                            <#else>
                                <span class="${properties.kcFormSocialAccountNameClass!}">
                                    <#if locale.current == 'Português (Brasil)'>
                                        Conta da
                                    </#if>
                                    ${p.displayName!}
                                </span>
                            </#if>
                        </a>
                    </li>
                </#list>
            </ul>
        </div>
    </#if>
</#if>

</@layout.registrationLayout>
