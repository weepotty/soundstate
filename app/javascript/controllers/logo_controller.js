import { Controller } from "@hotwired/stimulus";
import * as THREE from "three";
import { OrbitControls } from "three/examples/jsm/controls/OrbitControls.js";
import { FontLoader } from "three/examples/jsm/loaders/FontLoader.js";
import { TextGeometry } from "three/examples/jsm/geometries/TextGeometry.js";

// Connects to data-controller="logo"
export default class extends Controller {
  connect() {
    this.canvas = this.element;

    this.initScene();
    this.initCamera();
    this.renderer = new THREE.WebGLRenderer({ canvas: this.canvas });
    this.renderer.setSize(window.innerWidth, window.innerHeight);


    this.geometry = new THREE.TorusKnotGeometry(0.4, 0.15, 300, 300, 2, 3);
    this.material = new THREE.MeshNormalMaterial();
    // this.material = new THREE.MeshStandardMaterial({ color: 0x212121 });

    this.directionalLight = new THREE.DirectionalLight(0xffffff, 1);
    this.directionalLight.position.set(0, 1, 0);

    this.scene.add(this.directionalLight);

    this.controls = new OrbitControls(this.camera, this.canvas);
    this.controls.enableDamping = true
    this.camera.position.set(0, 0.5, 3);

    this.torus = new THREE.Mesh(this.geometry, this.material);
    // this.torus.position.y = -
    this.scene.add(this.torus);

    this.animate();
  }

  animate() {
    requestAnimationFrame(this.animate.bind(this));

    // update objects
    this.torus.rotation.y += 0.005;
    this.torus.rotation.x += 0.005;

    this.controls.update();

    this.renderer.render(this.scene, this.camera);
  }

  initScene() {
    this.scene = new THREE.Scene();
    this.scene.background = new THREE.Color( 0x202129)
  }
  initCamera() {
    this.camera = new THREE.PerspectiveCamera(60, window.innerWidth / window.innerHeight, 0.1, 1000);
  }

}
