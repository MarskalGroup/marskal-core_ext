# Changelog

#### 0.2.6.alpha - MAU `2017-12-01`  
** fixed a formatting problem that was causing mini-test to generate warnings
---

#### 0.2.5.alpha - MAU `2017-01-05`  
** Added <tt>merge</tt> & <tt>merge!</tt> to <tt>Array</tt> **

---

#### 0.2.4.alpha - MAU `2016-12-18`  
** A small tweak to <tt>remove_attr_accessors()</tt> **

---

#### 0.2.3.alpha - MAU `2016-12-18`  
** Added to Hash extension <tt>provide_default</tt>**

---

#### 0.2.2.alpha - MAU `2016-12-17`  
** Added NameError Exception in <tt>remove_attr_accessors</tt>**
* Changed <tt>Object</tt>  Extensions
    * Added NameError Exception in <tt>remove_attr_accessors</tt>
    * Reordered how I create and remove the methods to be more consistent with Ruby accessors
    * Added documents to reflect changes, and ran Tests

---

#### 0.2.1.alpha - MAU `2016-12-17`  
** Created <tt>Object</tt> and <tt>Symbol</tt> Extensions**
* Added <tt>Object</tt>  Extensions
    * Fully Documented and Tested
    * Added <tt>add_attr_accessors()</tt>
    * Added <tt>remove_attr_accessors()</tt>
* Added <tt>Symbol</tt> Extensions
    * Fully Documented and Tested
    * Added <tt>to_h</tt>
* Cleaned up some documentation errors

---

#### 0.2.0.alpha - MAU `2016-12-17`  
** Cleaned up and overuse of <tt>requires</tt> **
* All modules only <tt>require</tt> what they need
* Testing was modified as well
* <tt>all.rb</tt> was added to allow programmers to include all, 
  but now they can require only what they need in their application
* <tt>_common.rb</tt> was created for common constants and methods that can be shared by sub modules      

---

#### 0.1.11.alpha - MAU `2016-12-16`  
**Fixed Documentation Error for sort_and_include_index **

---

#### 0.1.10.alpha - MAU `2016-12-16`  
**Added blank? and sort_and_include_index methods**

* Added <tt>Hash</tt> Methods (fully tested and documented)
    * blank?
* Added <tt>Array Methods</tt> (fully tested and documented)
    * blank?
    * sort_and_include_index  (sorts an array while keep track of its index before sort)

---

#### 0.1.9.alpha - MAU `2016-12-14`  
**Added to_integer to String class**

---

#### 0.1.8.alpha - MAU `2016-12-12`  
**Tweaks to README.md**

---

#### 0.1.7.alpha - MAU `2016-12-12`  
**More cleanup in preparation of publishing the gem**

* Added some error handling to test helper
* Cleaned up some ambiguous code in string.rb

---

#### 0.1.6.alpha - MAU `2016-12-12`  
**Some cleanup in preparation ofr publishing the gem**

* Fixed gem install problems on linux
* Removed unused codde
* Removed old stashed code
* Cleaned up notes
* Add documentation instructions
* Removed Hanna format

---

#### 0.1.5.wip - MAU `2016-12-12`  
**Added methods to String class**

* Added All String methods from old gem, fully documented and tested

---

#### 0.1.4.wip - MAU `2016-12-12`  
**Added methods to I18n class**

* Added All I18n methods from old gem, fully documented and tested
* Cleaned up some other documentation

---

#### 0.1.3.wip - MAU `2016-12-12`  
**Added methods to Hash class**

* Added All Hash methods from old gem, fully documented and tested

---

#### 0.1.2.wip - MAU `2016-12-10`  
**Added methods to File and add a new module to support testing needs**

* Added All File methods from old gem
* Added Marskal::Testing::Utils methods to suppress and +puts+ output during testing

---

#### 0.1.1.wip - MAU `2016-12-10`  
**Added and Array, Date classes and custom assertions**

* Added All Array methods from old gem
* Added All Date methods from old gem
    * Some needed to be rewritten and/or deprecated
* Added <b>deprecate_this</b> for custom deprecation warnings
* Added custom assertions and expectation for minitest
* All methods should be fully documented to this point

---

#### 0.1.0.wip - MAU `2016-12-10`  
**Initial Version**

* Stubbed in the basic file structures
* Make sure dummy tests are running properly



