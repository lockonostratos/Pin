Wings.defineWidget 'customer',
  helpers:
    customers: -> Document.Customer.find()

  events:
    "click .doc-item": -> Wings.go('customer', @slug)
    "keyup input.insert": (event, template) ->
      if event.which is 13
        $companyName = $(template.find(".wings-field.insert"))
        Document.Customer.insert {
          creator    : Meteor.userId(),
          companyName: $companyName.val()
        }, (error, result) ->
          (console.log error; return) if error
          newCustomer = Document.Customer.findOne(result)
          Wings.go 'customer', newCustomer.slug