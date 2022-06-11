
### Context
We use tailwind, and some extra defined ccommon cclasses, usefull for qquick prototyping and have a coherent style across the app
this classes are defined iin `app.css`



#### Navbar
Overall app quick access accions, same for all views, located in the app.html and live.html respectively


#### Sub navbar
Speciific for each view, this is rendered in each view individually giving the choice to be unique if needed


#### View container

- common-container

#### UI components
common-button
``` html
<button class="common-button">Submit</button>
```

button-primary
``` html
<button class="button-primary">Submit</button>
```
section-container
``` html
<button class="section-container">Submit</button>
```

section-overlay
``` html
<button class="section-overlay">Submit</button>
```


### Structure of a basic app view / page

the common structure of the body of a webpage is a list of sections [ navbar, subnav, section1, section2, ... ]

usually a section looks like this:
``` html
<!-- body -->
    
<section class="common-section-overlay">
  <div class="common-container">


    <div class="common-form-header">
    <h1 class="text-xl font-bold">
        Custom view
    </h1>
    </div>
      <div class="common-form-section">
        <h2 class="md:w-1/3 mx-auto max-w-sm">Personal info</h2>
        <div class="md:w-2/3 mx-auto max-w-sm space-y-5">
          other info
        </div>
        <hr>
      </div>
      
  </div>
</section>

<!-- /body -->

```