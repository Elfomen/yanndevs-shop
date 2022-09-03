Adding an Image Preview

Important - this lecture fixes a bug you might be facing after the next lecture!

In the next lecture, we'll bring the image input to life and add an image preview.

In the video, showing an image preview works fine. For you, depending on the Flutter and Android versions you're using, it might not work.

In the next lecture, once we worked on the image input, adjust the input like this to make image preview work (upon pressing the "Confirm" button on the soft keyboard):

    Expanded(
      child: TextFormField(
        decoration: InputDecoration(labelText: 'Image URL'),
        keyboardType: TextInputType.url,
        textInputAction: TextInputAction.done,
        controller: _imageUrlController,
        onEditingComplete: () {
          setState(() {});
        },
      )
    ),

The onEditingComplete listener is not added in the video because it wasn't needed in the past. By adding it now and by calling setState() in there (even though it's empty), we force Flutter to update the screen, hence picking up the latest image value entered by the user.

It's not clear whether that's a bug or feature - the above code snippet will fix it though.