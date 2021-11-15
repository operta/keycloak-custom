<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
        ${msg("loginAccountTitle")}
    <#elseif section = "form">
        <div id="kc-form">
            <div id="kc-form-wrapper">
                <#if realm.password>
                    <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}"
                          method="post">
                        <div class="${properties.kcFormGroupClass!} has-icon-left mb-4">
                            <#if usernameEditDisabled??>
                                <input tabindex="1" id="username"
                                       class="${properties.kcInputClass!}"
                                       name="username" value="${(login.username!'')}" type="text" disabled
                                       placeholder="${msg("email")}"/>
                            <#else>
                                <input tabindex="1" id="username"
                                       class="${properties.kcInputClass!}"
                                       name="username" value="${(login.username!'')}" type="text" autofocus
                                       autocomplete="off" placeholder="${msg("email")}"
                                       aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                                />
                            </#if>
                            <div class="form-control-icon">
                                <i class="bi bi-person"></i>
                            </div>
                        </div>

                        <div class="${properties.kcFormGroupClass!} has-icon-left mb-4">
                            <input tabindex="2" id="password"
                                   class="${properties.kcInputClass!}"
                                   name="password" type="password" autocomplete="off" placeholder="${msg("password")}"
                                   aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                            />
                            <div class="form-control-icon">
                                <i class="bi bi-shield-lock"></i>
                            </div>
                        </div>

                        <#if messagesPerField.existsError('username','password')>
                            <div class="alert alert-light-danger color-danger">
                                ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                            </div>
                        </#if>

                        <div class="${properties.kcFormGroupClass!} has-icon-left mb-4">
                            <#if realm.rememberMe && !usernameEditDisabled??>
                                <div class="form-check form-check-lg d-flex align-items-end">
                                    <#if login.rememberMe??>
                                        <input class="form-check-input me-2" tabindex="3" id="rememberMe"
                                               name="rememberMe" type="checkbox" checked>
                                    <#else>
                                        <input class="form-check-input me-2" tabindex="3" id="rememberMe"
                                               name="rememberMe" type="checkbox">

                                    </#if>
                                    <label class="form-check-label text-gray-600" for="flexCheckDefault">
                                        ${msg("rememberMe")}
                                    </label>
                                </div>
                            </#if>
                        </div>

                        <div id="kc-form-buttons" class="${properties.kcFormGroupClass!} mb-4">
                            <input type="hidden" id="id-hidden-input" name="credentialId"
                                   <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                            <input tabindex="4"
                                   class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}"
                                   name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
                        </div>
                    </form>
                </#if>
            </div>

            <#if realm.password && social.providers??>
                <div id="kc-social-providers" class="${properties.kcFormSocialAccountSectionClass!}">
                    <hr/>
                    <h4>${msg("identity-provider-login-label")}</h4>

                    <ul class="${properties.kcFormSocialAccountListClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountListGridClass!}</#if>">
                        <#list social.providers as p>
                            <a id="social-${p.alias}"
                               class="${properties.kcFormSocialAccountListButtonClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountGridItem!}</#if>"
                               type="button" href="${p.loginUrl}">
                                <#if p.iconClasses?has_content>
                                    <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!}" aria-hidden="true"></i>
                                    <span class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text">${p.displayName!}</span>
                                <#else>
                                    <span class="${properties.kcFormSocialAccountNameClass!}">${p.displayName!}</span>
                                </#if>
                            </a>
                        </#list>
                    </ul>
                </div>
            </#if>

        </div>
    <#elseif section = "info" >
        <#if realm.resetPasswordAllowed>
            <div class="row">
                <div class="col-12">
                     <span>
                         <a class="font-bold" tabindex="5"
                            href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a>
                     </span>
                </div>
            </div>

        </#if>
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <div class="row">
                <div class="col-12">
                    <span>${msg("noAccount")}
                        <a tabindex="6" class="font-bold" href="${url.registrationUrl}">${msg("doRegister")}</a>
                    </span>
                </div>
            </div>
        </#if>
    </#if>

</@layout.registrationLayout>
