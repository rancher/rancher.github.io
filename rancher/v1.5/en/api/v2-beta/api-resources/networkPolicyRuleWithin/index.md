---
title: Rancher API - networkPolicyRuleWithin
layout: rancher-api-v2-beta-default-v1.5
version: v1.5
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.5/zh/api/v2-beta/api-resources/networkPolicyRuleWithin/
---

## NetworkPolicyRuleWithin




### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/networkPolicyRuleWithins</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{}' 'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/networkPolicyRuleWithins'
{% endhighlight %}
</div></div>



