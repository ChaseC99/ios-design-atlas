// Keep GitHub-friendly Markdown while the website supplies its own title,
// capture gallery, and syntax-highlighted source section.
export default function catalogMarkdown() {
  return tree => {
    let inRenderedSection = false;
    tree.children = tree.children.filter(node => {
      if (node.type === 'heading' && node.depth === 1) return false;
      if (node.type === 'heading' && node.depth === 2) {
        inRenderedSection = ['Captures', 'Swift source'].includes(node.children.map(child => child.value ?? '').join(''));
      }
      return !inRenderedSection;
    });
    function visit(node) {
      if (node.type === 'link' && /^[^:/]+\.swift$/.test(node.url)) node.url = '#swift-source';
      for (const child of node.children ?? []) visit(child);
    }
    visit(tree);
  };
}
