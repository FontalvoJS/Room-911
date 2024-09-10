@extends('layouts.app')

@section('content')

    <room-component :id="{{json_encode($id)}}"></room-component>

@endSection