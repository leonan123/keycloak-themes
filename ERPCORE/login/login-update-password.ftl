<#import "template.ftl" as layout>
<#import "password-commons.ftl" as passwordCommons>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('password','password-confirm'); section>
    <#if section = "header">
        <h1 class="heading-1">${msg("updatePasswordTitle")}</h1>
    <#elseif section = "form">
        <form id="kc-passwd-update-form" class="mt-8" action="${url.loginAction}" method="post" has-validations>
            <div class="form-group">
                <label for="password-new">${msg("passwordNew")}</label>
                
                <div class="input-password-container">
                    <input type="password" id="password-new" name="password-new" class="input"
                        autofocus autocomplete="new-password"
                        aria-invalid="<#if messagesPerField.existsError('password','password-new')>true</#if>"
                    />
                    <span id="input-error-username" class="input-error-message mt-1 <#if !messagesPerField.existsError('password-new')>hidden</#if>" aria-live="polite">
                        <#if messagesPerField.existsError('username')> 
                            ${kcSanitize(messagesPerField.get('password'))?no_esc}
                        </#if>
                    </span>
                    <button class="password-visibility-button" type="button" aria-label="${msg("showPassword")}"
                            aria-controls="password-new" data-password-toggle
                            data-icon-show="/img/icon-show-password.svg" data-icon-hide="/img/icon-hide-password.svg"
                            data-label-show="${msg('showPassword')}" data-label-hide="${msg('hidePassword')}"
                            tabindex="-1">
                        <img src="${url.resourcesPath}/img/icon-show-password.svg" />
                    </button>
                </div>
            </div>

            <div class="form-group">
                <label for="password-confirm">${msg("passwordConfirm")}</label>
                
                <div class="input-password-container">
                    <input type="password" id="password-confirm" name="password-confirm"
                        class="input"
                        autocomplete="new-password"
                        aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>"
                    />            
                    <span id="input-error-password-confirm" class="input-error-message mt-1 <#if !messagesPerField.existsError('password-confirm')>hidden<#else>inline-block</#if>"" aria-live="polite">
                        <#if messagesPerField.existsError('password-confirm')>
                            ${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}
                        </#if>
                    </span>
                    <button class="password-visibility-button" type="button" aria-label="${msg("showPassword")}"
                        aria-controls="password-confirm" data-password-toggle
                        data-icon-show="/img/icon-show-password.svg" data-icon-hide="/img/icon-hide-password.svg"
                        data-label-show="${msg('showPassword')}" data-label-hide="${msg('hidePassword')}"
                        tabindex="-1">
                        <img src="${url.resourcesPath}/img/icon-show-password.svg" />
                    </button>
                </div>
            </div>

            <div id="password-messages" class="my-5 space-y-1">
                <p id="minLength" class="description">${msg('passwordMinLengthMessage')}</p>
                <p id="upperCaseLetters" class="description">${msg('passwordMinUpperCaseCharsMessage')}</p>
                <p id="lowerCaseLetters" class="description">${msg('passwordMinLowerCaseCharsMessage')}</p>
                <p id="numbers" class="description">${msg('PasswordMinDigitsMessage')}</p>
                <p id="specialCharacters" class="description">${msg('passwordMinSpecialCharsMessage')} ! @ # $ % & * - _ ?</p>
            </div>
            
            <div class="form-group">
                <@passwordCommons.logoutOtherSessions/>

                <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!} mt-5">
                    <#if isAppInitiatedAction??>
                        <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" type="submit" value="${msg("doSubmit")}" />
                        <button class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!}" type="submit" name="cancel-aia" value="true" />${msg("doCancel")}</button>
                    <#else>
                        <button class="button button-primary" type="submit">
                            ${msg("doSubmitUpdatePassword")}
                        </button>
                    </#if>
                </div>
            </div>
        </form>
        <script type="module" src="${url.resourcesPath}/js/passwordVisibility.js"></script>
        <script type="module" src="${url.resourcesPath}/js/validations.js"></script>
    </#if>
</@layout.registrationLayout>
