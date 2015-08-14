# iOS autocomplete

A simple, yet very useful feature - autocomplete textfield.  IOS autocomplete is an iOS module that behaves like a normal text field with the added functionality that it provides suggestions to the user in a dropdown.

#Usage

In order to use IOS autocomplete you need to follow some necesarry steps.

1) Add the following classes in your projects: AutoCompletionTextField, AutoCompletionDataSource, AutoCompletionTextFieldDataSource, AutoCompletionTextFieldDelegate, AutoCompletionAnimator

2) Add an autocompletion instance inside a view, either by drag and drop in a xib of a UITextField and changing its class to AutoCompletionTextField or instantiate it and add it as a subview

3) Set the suggestionsResultDataSource. The data source needs to conform to the protocol AutoCompletionTextFieldDataSource

4) Optional you can also set the suggestionsResultDelegate in order to handle the suggestion selection. Also you can set the animationDelegate in order to provide a custom animation to displaying of the results

# About this project
![3Pillar Global] (http://www.3pillarglobal.com/wp-content/themes/base/library/images/logo_3pg.png)

This project is developed and maintained by [3Pillar Global](http://www.3pillarglobal.com/).


