<#import  "/master/master-blank.ftl" as masterBlank>

<#macro masterFrame showNotice=false title="网上党校"  bodyClass="overflow-hidden">
<@masterBlank.masterBlank title=title bodyClass=bodyClass>

<!-- Overlay Div -->
<div id="overlay" class="transparent"></div>

<div id="wrapper" class="preload">

    <@masterBlank.header></@masterBlank.header>

    <div id="landing-content">
        <#nested >
    </div><!-- /landing-content -->

    <@masterBlank.footer></@masterBlank.footer>

</div><!-- /wrapper -->

<a href="#" id="scroll-to-top" class="hidden-print"><i class="fa fa-chevron-up"></i></a>

<@masterBlank.js></@masterBlank.js>

</@masterBlank.masterBlank>
</#macro>

	