import React from "react";
import { createRoot } from "react-dom/client";

//function (arrow function) or comonent in the react
const HeadingComponent = () =>{
    return (
        <div>
            <h1>heading from react component</h1>
        </div>
    );
};
var root= document.getElementById("mainRoot");
var rootReact=createRoot(root);
//otReact.render(<HeadingComponent/>);

//react element inside the react component

const heading1 =(
    <h1 className="heading" tabIndex="2">
        this is react heading element</h1>


);
const span= <span>{heading1}</span>;
const num1 =100;
const HeadingComponent1 = () => {
    return(
    <div id="container1">
        {num1+200}{heading1}<h2>{num1+300}</h2>
    </div>
    );
}
rootReact.render(<HeadingComponent1/>);