# terraform-NSGrules
Creating NSG rules dynamically.

This fork shows a couple of possible enhancements to the
[original approach](https://techlearning22334198.wordpress.com/2021/03/05/dynamically-adding-nsg-rules-with-terraform/).

## Optional Attributes

For resources like
[`azurerm_network_security_rule`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule)
that have lots of optional attributes it's handy being able to set some to `null`,
but it's still frustrating when you forget one or are trying to design a clean interface
to a [module](https://www.terraform.io/docs/language/modules/index.html).

Terraform v0.14 comes to the rescue with an experimental
[optional object attributes](https://www.terraform.io/docs/language/expressions/type-constraints.html#experimental-optional-object-type-attributes)
feature. Once this is enabled you can wrap an attribute type with `optional(...)` and
Terraform will automatically supply a `null` value if the user leaves the attribute
out. This is exactly what NSG rules need so fingers crossed it becomes an official
part of the language!

## Keying by Priority

Sometimes you need a group of NSGs that have a lot of rules in common, but
enough minor variations that it's difficult to come up with one core rule set
that works everywhere. Specifying rules as a map of objects gives us a neat
solution to this problem.

By using priority values as keys, you can code the exceptions to the common set
as a separate map then
[merge](https://www.terraform.io/docs/language/functions/merge.html)
the two together. Rules in the exception map will override rules in the base map
with the same priority: this is good when you intend to override them, but not
so good if someone accidentally re-uses a priority value and the first rule
silently vanishes! Still, the code demonstrates how to do this if it makes
sense for your situation.
