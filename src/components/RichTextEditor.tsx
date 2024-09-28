import React from 'react';
import { CKEditor } from "@ckeditor/ckeditor5-react";
import Editor from "ckeditor5-custom-build";

const editorConfiguration = {
  toolbar: {
    items: [
      'heading',
      '|',
      'bold',
      'italic',
      'link',
      'bulletedList',
      'numberedList',
      '|',
      'outdent',
      'indent',
      '|',
      //'imageUpload',
      'blockQuote',
      'insertTable',
      'mediaEmbed',
      'undo',
      'redo',
      'imageInsert',
      'horizontalLine',
      'highlight',
      'fontSize',
      'fontFamily',
      'findAndReplace',
      'fontBackgroundColor',
      'fontColor',
      'alignment',
      'ckbox'
    ]
  },
  language: 'en',
  image: {
    toolbar: [
      'imageTextAlternative',
      'toggleImageCaption',
      'imageStyle:inline',
      'imageStyle:block',
      'imageStyle:side'
    ]
  },
  table: {
    contentToolbar: [
      'tableColumn',
      'tableRow',
      'mergeTableCells'
    ]
  }
};


interface RichTextEditorProps {
  initialData: string;
  callback: (data: string) => void;
}

const RichTextEditor = (props: RichTextEditorProps) => {
  return (
    <CKEditor
      editor={Editor}
      config={editorConfiguration}
      data={props.initialData}
      onChange={(_, editor) => {
        const data = editor.getData();
        props.callback(data);
      }}
    />
  )
}

export default RichTextEditor;
