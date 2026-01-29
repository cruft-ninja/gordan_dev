# Google Workspace Prompt Framework

The preferred prompt framework across the sources, particularly for Google Workspace and general enterprise use, is the PTCF Framework, which consists of four main areas: Persona, Task, Context, and Format.

## The PTCF Framework Breakdown

While the Task is the only required component to initiate action, including the other three elements significantly enhances the accuracy and reliability of the model's output.

*   **Persona:** Defines the specific identity or expertise the model should adopt (e.g., "Act as a senior solution architect" or "You are a professional chef"). This helps the model use the appropriate tone and professional vocabulary.

*   **Task:** Specifies the core action or objective the AI needs to accomplish (e.g., "Summarize this document" or "Calculate the total funding amount"). Precise action verbs like "synthesize," "debug," or "standardize" are highly recommended.

*   **Context:** Provides the background information, situational details, or grounding data necessary for the task. In Google Workspace, this often involves using the @ mention feature to reference specific documents or spreadsheets from Google Drive.

*   **Format:** Describes the desired structure or presentation of the output (e.g., Markdown tables, JSON, bulleted lists, or a "pithy Tweet").

## Evolution for Gemini 3: "Less is More"

For the Gemini 3 series, the preferred framework shifts toward a more streamlined structure because the model is significantly better at inferring intent and maintaining structure from minimal cues. The updated template for Gemini 3 is:

*   **TASK:** A one-sentence goal.

*   **INPUT:** What you are providing (text, image, video).

*   **OUTPUT:** The format and key constraints.

## Specialized Frameworks

The sources also identify specialized frameworks for multimodal tasks like video generation:

*   **Veo 3.1 Framework:** `[Cinematography] + [Subject] + [Action] + [Context] + [Style and Ambiance]`

*   **CCAD Framework (Image-to-Video):** `[C]amera, [C]haracter, [A]ction, [D]ialogue`

## Analogy

If your request is a construction project, the Task is the actual building you want. The Persona is the specialized contractor you hire (architect vs. plumber), the Context is the site survey and blueprints you provide, and the Format is whether you want the final result as a scale model or a 3D digital walkthrough.
