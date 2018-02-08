import SirTrevor from 'sir-trevor';
import ButtonBlock from './button_block';
import ImageBlock from './image_block';
import QuestionBlock from './question_block';
import DividerBlock from './divider_block';

const defaultBlockTypes = [
  'Text',
  'List',
  'Quote',
  'Image',
  'Video',
  'Button'
];

export default function (el, blockTypes) {
  const editor = document.querySelector(el);

  if (editor) {
    blockTypes = (typeof blockTypes !== 'undefined') ?  blockTypes : defaultBlockTypes;

    SirTrevor.Blocks.Image = ImageBlock;
    SirTrevor.Blocks.Quote.prototype.textable = false;
    SirTrevor.Blocks.Quote.prototype.toolbarEnabled = true;
    SirTrevor.Blocks.Button = ButtonBlock;
    SirTrevor.Blocks.Button = ButtonBlock;
    SirTrevor.Blocks.Question = QuestionBlock;
    SirTrevor.Blocks.Divider = DividerBlock;

    SirTrevor.setDefaults({
      iconUrl: window.__assets.externalSirTrevorIcons,
      uploadUrl: '/admin/resources/upload',
      ajaxOptions: {
        credentials: 'include'
      }
    });

    return new SirTrevor.Editor({
      el: editor,
      defaultType: 'Text',
      blockTypes
    });
  }

}
