# Inheritance,

if you have a class Mammals

    class mammal {

    }

    and another class Person {

    }

the person class can ingerit the mammal class, but can ingerit only one class, so it cannot inherit mammal and another class again

    Class Person extends mammals{

    }

# Mixins

with mixins, you can mix many classes, they just work like classes but with the advantage that a class can mix more than one class

    mixin Agility {

    }

    mixin mammal {

    }

    class Person with Agility, mammals {

    }