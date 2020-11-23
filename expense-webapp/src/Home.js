import React, { Component } from 'react';
import mydata from './data/sample-plan.json';
import sampledata from './data/data.json';
import * as d3 from 'd3';



class Home extends Component {
    temperatureData = [ 8, 5, 13, 9, 12 ]
    state = { resources: [] }

    constructor(props){
      super(props);
      this.myRef = React.createRef(); 
   }

    async componentDidMount(){
      this.setState({data : mydata , isLoading: false}); 
      
      this.drawBarchart(mydata);

      d3.select(this.myRef.current)
      .append("div").append("p")
      .text("Hello from D3");

      console.log(this.myRef);
      console.log(mydata.configuration.root_module.resources);
    }

    drawChart(data) {
      const width = 954
      const height = 954;
      const root = d3.treemap(data);

      const svg = d3.create("svg")
          .attr("viewBox", [0, 0, width, height])
          .style("font", "10px sans-serif");
    
      const shadow = this.myRef.current.uid("shadow");
    
      svg.append("filter")
          .attr("id", "shadow.id")
        .append("feDropShadow")
          .attr("flood-opacity", 0.3)
          .attr("dx", 0)
          .attr("stdDeviation", 3);
    
      const node = svg.selectAll("g")
        .data(d3.group(root, d => d.height))
        .join("g")
          //.attr("filter", shadow)
        .selectAll("g")
        .data(d => d[1])
        .join("g")
          .attr("transform", d => `translate(${d.x0},${d.y0})`);
    
      node.append("title")
          .text(d => `${d.ancestors().reverse().map(d => d.data.name).join("/")}\n${d.value}`);
    
      node.append("rect")
          .attr("id", d => (d.nodeUid = this.myRef.current.uid("node")).id)
          //.attr("fill", d => color(d.height))
          .attr("width", d => d.x1 - d.x0)
          .attr("height", d => d.y1 - d.y0);
    
      node.append("clipPath")
          .attr("id", d => (d.clipUid = this.myRef.current.uid("clip")).id)
        .append("use")
          .attr("xlink:href", d => d.nodeUid.href);
    
      node.append("text")
          .attr("clip-path", d => d.clipUid)
        .selectAll("tspan")
        .data(d => d.data.name.split(/(?=[A-Z][^A-Z])/g).concat(d.value))
        .join("tspan")
          .attr("fill-opacity", (d, i, nodes) => i === nodes.length - 1 ? 0.7 : null)
          .text(d => d);
    
      node.filter(d => d.children).selectAll("tspan")
          .attr("dx", 3)
          .attr("y", 13);
    
      node.filter(d => !d.children).selectAll("tspan")
          .attr("x", 3)
          .attr("y", (d, i, nodes) => `${(i === nodes.length - 1) * 0.3 + 1.1 + i * 0.9}em`);
    
      return svg.node();
    }

    drawBarchart(data) {
      const svgCanvas = d3.select(this.myRef.current)
      .append("svg")
      .attr("width", 600)
      .attr("height", 400)
      .style("border", "1px solid black");
    }

    render() { 
        return (
            <div>
              <div ref={this.myRef}></div>
              <div ref="temperatures"></div>
              <h2 style={{display: 'flex',  justifyContent:'center', alignItems:'center', height: '100vh'}}>
                Welcome to easy expense app ! 
              </h2>
             
            </div>
              
            );
    }
}
 
export default Home;