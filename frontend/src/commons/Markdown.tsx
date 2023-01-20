import * as React from 'react';
import ReactMarkdown from 'react-markdown';
import MathJax from 'react-mathjax';
import remarkMath from 'remark-math';

/*
	Markdown Object renders Markdown Syntax and LaTeX
	
	For now, div and span are used instead of the original <math> 
	and <inlineMath> HTML objects.
*/

class MarkdownRender extends React.Component {
	constructor(props) {
		super(props);
		this.newProps = {
			...this.props,
			remarkPlugins: [
				remarkMath,
			],
			components: {
				div: (props) =>
					<MathJax.Node formula={props.children} />,
				span: (props) =>
					<MathJax.Node inline formula={props.children} />
			}
		};
	}

	shouldComponentUpdate(nextProps) {
		if( nextProps == this.props ) {
			return false;
		}
		return true;
	}

	render() {
		return(
			<MathJax.Provider input="tex">
				<ReactMarkdown {...this.newProps}></ReactMarkdown>
			</MathJax.Provider>
		);
	}
}

export default MarkdownRender;

